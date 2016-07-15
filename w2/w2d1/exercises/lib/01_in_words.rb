class Fixnum
  def in_words
    return 'zero' if zero?
    words = []
    groups = process(self)

    groups.each_with_index do |group, index|
      words << translate(group, index)
    end

    rev_words = trim(words.reverse)
    rev_words.join(' ').strip
  end

  def process(number)
    numbers = number.to_s.split('')
    groups = []

    while numbers.length > 0
      sub_group = []
      3.times do
        sub_group << numbers.pop.to_i
      end

      groups << sub_group.reverse
    end
    groups
  end

  def translate(sub_group, group_number)
    sub_string = []

    sub_string << hundreds(sub_group)
    sub_string << tens(sub_group) unless sub_group[1] == 1
    sub_string << ones(sub_group)

    if sub_group.any? { |digit| digit != 0}
      sub_string << post_fix(group_number)
    end

    trimmed_group = trim(sub_string)
    trimmed_group.join(' ').strip
  end

  def post_fix(group_number)
    powers = {1 => 'thousand', 2 => 'million',
                3 => 'billion', 4 => 'trillion', 5 => 'quadrillion'}

    powers[group_number]
  end

  def ones(sub_group)
    digit_one = sub_group[2]
    digit_ten = sub_group[1]

    one_words = {1 => 'one', 2 => 'two', 3 => 'three',
                4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven',
                8 => 'eight', 9 => 'nine'}

    misc_teens = {0 => 'ten', 1 => 'eleven', 2 => 'twelve',
                  3 => 'thirteen', 4 => 'fourteen', 5 => 'fifteen',
                  6 => 'sixteen', 7 => 'seventeen', 8 => 'eighteen',
                  9 => 'nineteen'}

    if digit_ten == 1
      misc_teens[digit_one]
    else
      one_words[digit_one]
    end
  end

  def tens(sub_group)
    # no need for a 1 definition bec 'ones' gets called in that case
    ten_words = {2 => 'twenty', 3 => 'thirty',
                4 => 'forty', 5 => 'fifty', 6 => 'sixty',
                7 => 'seventy', 8 => 'eighty', 9 => 'ninety'}

    ten_words[sub_group[1]]
  end

  def hundreds(sub_group)
    digit_hundred = sub_group[0]
    sub_string = []

    unless digit_hundred == 0
      sub_string << ones([0,0, digit_hundred])
      sub_string << 'hundred'
    end

    sub_string.join(' ').strip
  end

  def zero?
    self == 0
  end

  def trim(words)
    trimmed_words = []
    words.each do |word|
      trimmed_words << word unless word == nil || word.empty?
    end

    trimmed_words
  end
end

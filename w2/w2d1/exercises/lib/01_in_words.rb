class Fixnum
  def in_words
    words = []
    groups = process(self)
    groups.each_with_index do |group, index|
      words << translate(group, index)
    end
    rev_words = words.reverse
    rev_words.join(' ').strip
  end

#  private

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
    digit_one = sub_group[2]
    digit_ten = sub_group[1]
    digit_hundred = sub_group[0]

    sub_string = []

    sub_string << hundreds(digit_hundred)
    sub_string << tens(digit_ten) unless digit_ten == 1
    sub_string << ones(digit_one, digit_ten, digit_hundred)
    sub_string << post_fix(group_number)

    sub_string.join(' ').strip
  end

  def post_fix(group_number)
    thousands = {0 => '', 1 => 'thousand', 2 => 'million', 3 => 'billion',
                4 => 'trillion', 5 => 'quadrillion'}
    thousands[group_number]
  end

  def ones(digit_one, digit_ten, digit_hundred)
    one_words = {1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
                5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight',
                9 => 'nine'}
    misc_teens = {1 => 'eleven', 2 => 'twelve', 3 => 'thirteen',
                4 => 'fourteen', 5 => 'fifteen', 6 => 'sixteen',
                7 => 'seventeen', 8 => 'eighteen', 9 => 'nineteen'}

    if digit_ten == 1
      misc_teens[digit_one]
    elsif digit_one == 0 && digit_ten == 0 && digit_hundred == 0
      return 'zero'
    else
      one_words[digit_one]
    end
  end

  def tens(digit)
    ten_words = {0 => '', 1 => 'ten', 2 => 'twenty', 3 => 'thirty',
                4 => 'fourty', 5 => 'fifty', 6 => 'sixty', 7 => 'seventy',
                8 => 'eighty', 9 => 'ninety'}

    ten_words[digit]
  end

  def hundreds(digit)
    sub_string = []

    unless digit == 0
      sub_string << ones(digit, 0)
      sub_string << 'hundred'
    end

    sub_string.join(' ')
  end
end

# NEED TO FIX ZERO BUG WHEN NUMBERS OUTSIDE THE GROUP != 0, BUT THE GROUP IS FULL OF ZEROES
# ALSO FIX NOT READING MILLION DIGIT PROPERLY

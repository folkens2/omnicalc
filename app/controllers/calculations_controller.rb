class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length
    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tab = text_wo_cr.gsub("\t","")

    @character_count_without_spaces = text_wo_cr.length

    down_case = @text.downcase
    no_punctuation = down_case.gsub(/[^a-z0-9\s]/i,"")
    clean_word_array = no_punctuation.split

    @occurrences = clean_word_array.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_apr = @apr/100/12
    months = @years*12
    numerator = monthly_apr*((1+monthly_apr)**months)
    denominator = ((1+monthly_apr)**months) - 1

    @monthly_payment = @principal*(numerator/denominator)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    date_diff = @ending - @starting

    @seconds = date_diff
    @minutes = date_diff/60
    @hours = date_diff/(60*60)
    @days = date_diff/(60*60*24)
    @weeks = date_diff/(60*60*24*7)
    @years = date_diff/(60*60*24*7*52)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    if @numbers.count.odd?
      range_odd_count = @numbers.count / 2
      @median = @sorted_numbers[range_odd_count]
    elsif @numbers.count.even?
      range_even_count_upper = @numbers.count / 2
      range_even_count_lower = @numbers.count / 2 - 1
      @median = (@sorted_numbers[range_even_count_upper] + @sorted_numbers[range_even_count_lower])/2
    else
      @median = "Error"
    end

    @sum = @numbers.sum

    @mean = (@numbers.sum)/@numbers.count

    # (each value - mean) squared and then sum that all up

    mean = @mean
    squared_diffs = []

    @numbers.each do |number|
      mean_diff = (number - mean)
      squared_mean_diff = (mean_diff)**2
      squared_diffs.push(squared_mean_diff)
    end

    @variance = squared_diffs.sum / (squared_diffs.count - 1)

    @standard_deviation = Math.sqrt(@variance)

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

defmodule TN do


  #Start Tidy
  def st do
    numberOfInputsAndList = getFileTextInformation()
    {:ok, file} = File.open "output.txt", [:write]
    loopNumbers(1,String.to_integer(hd(numberOfInputsAndList)), hd(tl(numberOfInputsAndList)), file)
    File.close file
  end


  def getFileTextInformation do
    fileText = String.split(File.read!("input.txt"),"\n")
    [hd(fileText), tl(fileText)]
  end

#  Iterates the numbers list
  def loopNumbers(caseNumber, numberId, listOfNumbers, file) do
    if numberId > 0 do
      #      newId = numberId-1
      #      IO.puts hd(listOfNumbers)
      numberToWorkOn = hd(listOfNumbers)
      lengthOfNumber = String.length(numberToWorkOn)
      tidyNumber = isNumberTidy?(numberToWorkOn, lengthOfNumber, lengthOfNumber,1)
      IO.puts "Tidy Number: " <> tidyNumber
      IO.binwrite file, "Case #" <> Integer.to_string(caseNumber) <> ": " <> tidyNumber <> "\n"
      #      IO.puts tidyNumber
      loopNumbers(caseNumber+1,numberId-1,tl(listOfNumbers), file)

    end
  end

#  Checks if the number is tidy starting from right to left
  def isNumberTidy?(number,numOriginalLength, numberLength, numberOfChecks) do
    IO.puts "\nNumber: "<>number
    IO.puts "Number Length: "<>Integer.to_string(numberLength)

    if numOriginalLength <= 1 do
      IO.puts "Number" <> number
      number
    else
      if numberLength > 1 do
        IO.puts String.to_integer(String.at(number,numberLength-1))
        IO.puts String.to_integer(String.at(number,numberLength-2))
        if String.to_integer(String.at(number,numberLength-1)) >= String.to_integer(String.at(number,numberLength-2)) do
          isNumberTidy?(number, numOriginalLength, numberLength-1, numberOfChecks+1)
        else
          numberMinusOne = String.to_integer(String.at(number,numberLength-2))-1

          if numberLength > 2 || (numberLength > 1 && numberMinusOne > 0) do
            newNum = String.slice(number,0,numberLength-2) <> Integer.to_string(numberMinusOne) <> changeNumbersTo9(numberOfChecks)
            isNumberTidy?(newNum, numOriginalLength, numberLength-1, numberOfChecks+1)
          else
            newNum = String.slice(number,0,numberLength-2) <> changeNumbersTo9(numberOfChecks)
            isNumberTidy?(newNum, numOriginalLength, numberLength-1, numberOfChecks+1)
          end

        end
      else
        IO.puts "New num:" <>  number
        number
      end
    end

  end

#  Adds 9s after the checked number
  def changeNumbersTo9(numberLength) do
    if numberLength > 0 do
      "9" <> changeNumbersTo9(numberLength-1)
    else
      ""
    end
  end



end

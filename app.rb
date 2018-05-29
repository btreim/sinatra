require "sinatra"
require "sinatra/reloader"

#ROOT
get '/' do
  erb :index, layout: :main
end

#SUBMIT FORM
post '/encode' do
  word = params["word"]
  offset = params["offset"]
  encoded = caeser_cipher(word,offset)
  erb :encoded, layout: :main, :locals => {:encoded => encoded}
end

def caeser_cipher(someString, shift)
  if someString == nil
    return ""
  end
  letter = someString.split("")
  upCase= ("A".."Z").to_a
  lowCase = ("a".."z").to_a
  encoded = Array.new
  letter.each do |x|
    if upCase.include?(x)
      index = upCase.index(x)
      newNum = index.to_i + shift.to_i
      until newNum <= 26
        newNum = newNum - 25
      end
      newLet = upCase[newNum]

      encoded << newLet

    elsif lowCase.include?(x)
      index = lowCase.index(x)
      newNum = index.to_i + shift.to_i
      until newNum <= 26
        newNum = newNum - 26
      end
      newLet = lowCase[newNum]

      encoded << newLet

    else
      encoded << x
    end
  end
  return encoded.join("")
end

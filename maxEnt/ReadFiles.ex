defmodule ReadFiles do
    def getClass1Names do
        {_,files} = File.ls("./Class1")
        addDoc = (fn({first, second}) -> {Path.join("./Class1",first),second} end)
        fullName = (fn({first, second}) -> {Path.absname(first),second} end)
        nameCopy = (fn(elem) -> {elem, elem} end)
        files
        |>Enum.map(nameCopy)
        |>Enum.map(addDoc)
        |>Enum.map(fullName)
    end
    
    def getClass2Names do
        {_,files} = File.ls("./Class2")
        addDoc = (fn({first, second}) -> {Path.join("./Class2",first),second} end)
        fullName = (fn({first, second}) -> {Path.absname(first),second} end)
        nameCopy = (fn(elem) -> {elem, elem} end)
        files
        |>Enum.map(nameCopy)
        |>Enum.map(addDoc)
        |>Enum.map(fullName)
    end
    
    def getTextFromName({fullPath, name}) do
        text = File.read!(fullPath)
        {name, text}
    end
    
    
    def repl files do
        input = IO.gets("Enter search term or 'q' to quit: ")
        unless input == "q\n"  do
            IO.inspect(input)
            repl files
        end
    end
    
    def main do
        class1 = getClass1Names
        class2 = getClass2Names
        nameFilter = (fn(elem) -> 
            getTextFromName(elem) end)
            
        class1 = Enum.map(class1, nameFilter)
        class2 = Enum.map(class2, nameFilter)
        IO.inspect(class1)
        IO.inspect(class2)
        
        repl {class1,class2}
    end
        
    
end
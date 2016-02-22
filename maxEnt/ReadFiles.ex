defmodule ReadFiles do
    def getClass1Names do
        {_,files} = File.ls("./Class1")
        addDoc = (fn(elem) -> Path.join("./Class1",elem) end)
        fullName = (fn(elem) -> Path.absname(elem) end)
        files
        |>Enum.map(addDoc)
        |>Enum.map(fullName)
    end
    
    def getClass2Names do
        {_,files} = File.ls("./Class2")
        addDoc = (fn({first, second}) -> {Path.join("./Class2",fisrt),second} end)
        fullName = (fn({first, second}) -> {Path.absname(first),second} end)
        nameCopy = (fn(elem) -> {elem, elem} end)
        files
        |>Enum.map(nameCopy)
        |>Enum.map(addDoc)
        |>Enum.map(fullName)
    end
    
    def getFileName value do
        {_,files} = File.ls(".")
        nameCheck = (fn(elem) -> ((value == elem) || (value == Path.basename(elem))) end)
        files
        |>Enum.filter(nameCheck)
    end
    
    def getTextFromName({fullPath, name}) do
        text = File.read!(fullPath)
        {name, text}
    end
    
   # def displayFiles do
   #     fileNames = getFileNames
   #     files = Enum.map(fileNames, (fn(elem) -> 
   #         {Path.basename(elem), File.read!(elem)} end))
   #     IO.inspect(files)
   # end
    
    def repl files do
        input = IO.gets("Enter search term or 'q' to quit: ")
        unless input == "q\n"  do
            IO.inspect(input)
            repl files
        end
    end
    
    def doWorkOnFiles(files, input) do
        fun = (fn(elem) -> work(elem,input)end)
        Enum.filter(files, fun)
    end
    
    def work({filePath,_}, input) do
        ext = Path.extname(filePath)
        name = Path.basename(filePath,ext)
        fileFirst = List.first(String.split(name))
        inputFirst = List.first(String.split(input))
        IO.inspect(fileFirst)
        IO.inspect(inputFirst)
        fileFirst == inputFirst
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
        
        repl filesWithData
    end
        
    
end
defmodule ReadFiles do
    def getFileNames do
        {_,files} = File.ls("./Documents")
        addDoc = (fn(elem) -> Path.join("./Documents",elem) end)
        fullName = (fn(elem) -> Path.absname(elem) end)
        files
        |>Enum.map(addDoc)
        |>Enum.map(fullName)
    end
    
    def displayFiles do
        fileNames = getFileNames
        files = Enum.map(fileNames, (fn(elem) -> 
            {Path.basename(elem), File.read!(elem)} end))
        IO.inspect(files)
    end
    
    def repl files do
        input = IO.gets("Enter search term or 'q' to quit: ")
        unless input == "q\n"  do
        results = doWorkOnFiles(files, input)
        IO.inspect(input)
        IO.inspect(results)
        repl files
        end
    end
    
    def doWorkOnFiles(files, input) do
        fun = (fn(elem) -> work(elem,input)end)
        Enum.filter(files, fun)
    end
    
    def work(filePath, input) do
        ext = Path.extname(filePath)
        name = Path.basename(filePath,ext)
        fileFirst = String.first(name)
        inputFirst = String.first(input)
        fileFirst == inputFirst
    end
    
    def main do
        files = getFileNames
        repl files
    end
        
    
end
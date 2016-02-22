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
    
    
    def repl data do
        {classes, lambdas, funcs} = data
        input = IO.gets("Enter search term or 'q' to quit: ")
        input = String.rstrip(input)
        unless input == "q"  do
            name = Path.join("./Documents",input)
            secondName = Path.absname(name)
            {result,inputFile} = File.read(secondName)
            IO.inspect(secondName)
            if result == :ok do
                IO.inspect(Entropy.classify(inputFile,classes,lambdas,funcs))
                IO.inspect(inputFile)
            else
                IO.inspect(result)
            end
            repl data
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
        #generate classified stuff
        classes = [1,2]
        initial = [1,1]
        documents = ["hogwash and slop", "who knows anymore"]
        featureFuncs = [(fn(d,c) -> Entropy.count_appearances(d, "the")/Entropy.words(d) end), (fn(d,c) -> Entropy.count_appearances(d,"a")/Entropy.words(d) end)]
        lambdas = Entropy.train(documents,classes,initial,featureFuncs)
        #lambdas = [1,1]
        repl {classes,lambdas,featureFuncs}
    end
        
end


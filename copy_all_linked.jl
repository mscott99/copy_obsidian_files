#usage: julia copy_all_linked.jl ~/Obsidian/myVault/Zettelkasten/Unevenly\ Sampled\ ShareFile.md ~/Obsidian/myVault/Zettelkasten/ ~/Obsidian/GenerativeFourierVault/Zettelkasten
#ARGS = ["./myVault/Zettelkasten/Unevenly Sampled ShareFile.md", "./myVault/Zettelkasten/", "./GenerativeFourierVault/Zettelkasten/"]

using FileIO: read

if ARGS[1] == "--help" || ARGS[1] == "-h"
    println("usage: julia copy_all_linked.jl [--help|-h] LINKFILE COPYROOTFOLDER PASTEROOTFOLDER")
end

filetext = read(ARGS[1], String)
matchwiki = r"(?<=\[\[).+(?=\]\])"
for matchobj in eachmatch(matchwiki, filetext)
    filename = matchobj.match * ".md"
    try
        cp(joinpath(ARGS[2], filename), joinpath(ARGS[3], filename), force=true)
    catch
        filename = matchobj.match
        cp(joinpath(ARGS[2], filename), joinpath(ARGS[3], filename), force=true)
    end
end
@info "All files copied."
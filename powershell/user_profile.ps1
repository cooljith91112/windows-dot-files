#Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt star
Import-Module -Name Terminal-Icons
# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias -Name lv -Value Love2D

## Git Alias
Set-Alias g git
Set-Alias -Name gdiff -Value GitDiff
Set-Alias -Name branch -Value GitCurrentBranch
Set-Alias -Name gg -Value GitGui
Set-Alias -Name gbs -Value GitSearchBranch
Set-Alias -Name push -Value GitPush

function GitDiff {
    $output = (git diff --stat) | Out-String
    if (!$output) {
        Write-Output "NONE"
    } else {
        Write-Output $output
    }
}

function GitCurrentBranch {
    $output = (git branch) | grep '*' | Out-String
    Write-Output $output
}

function GitGui {
    (git gui)
}

function GitSearchBranch {
    $output = (git branch) | grep $args[0] | Out-String
    Write-Output $output
}

function Love2D {
    (love . --console)
}

function GitPush{
    if(($args.Length -lt 2) -or ($args.Length -gt 2)) {
        Write-Output "Usage: push <origin> <branch>"
    } else {
        (git push -u $args[0] $args[1])
    }
}

#Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt default
Import-Module -Name Terminal-Icons
# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias htop ntop
Set-Alias -Name lv -Value Love2D
Set-Alias guid New-Guid
Set-Alias exif 'C:\tools\exiftool(-k).exe'

## Git Alias
Set-Alias g git
Set-Alias -Name gdiff -Value GitDiff
Set-Alias -Name branch -Value GitCurrentBranch
Set-Alias -Name gg -Value GitGui
Set-Alias -Name gbs -Value GitSearchBranch
Set-Alias -Name push -Value GitPush
Set-Alias -Name status -Value GitStatus
Set-Alias -Name pcb -Value PushCurrentBranch

function GitDiff {
    $output = (git diff --stat) | Out-String
    if (!$output) {
        Write-Output "NONE"
    }
    else {
        Write-Output $output
    }
}

function GitCurrentBranch {
    $output = (git branch) | grep '*' | Out-String
    $branchName = $output -replace '[*?\{]', '' -replace "\s", ""
    Write-Output "`nCurrent Branch is: $branchName `n"
    if (($args.Length -gt 0) -and ($args[0] -eq "copy")) {
        Set-Clipboard -Value $branchName
        Write-Output "Branch Name Copied to Clipboard!`n"
    }
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

function GitPush {
    if (($args.Length -lt 2) -or ($args.Length -gt 2)) {
        Write-Output "Usage: push <origin> <branch>"
    }
    else {
        (git push -u $args[0] $args[1])
    }
}

function GitStatus {
    $output = (git diff --stat)
    Write-Output $output
}

function PushCurrentBranch {
    $branchQuery = (git branch) | grep '*' | Out-String
    $branchName = $branchQuery -replace '[*?\{]', '' -replace "\s", ""
    $originQuery = (git config --get remote.origin.url)
    (git push -u $originQuery $branchName)
}

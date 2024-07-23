# Import the required .NET classes for hashing
Add-Type -TypeDefinition @"
    using System;
    using System.IO;
    using System.Security.Cryptography;

    public class HashUtilities
    {
        public static string ComputeHash(string filePath, string hashAlgorithm)
        {
            using (FileStream stream = File.OpenRead(filePath))
            {
                HashAlgorithm algorithm;
                switch (hashAlgorithm.ToUpper())
                {
                    case "MD5":
                        algorithm = MD5.Create();
                        break;
                    case "SHA1":
                        algorithm = SHA1.Create();
                        break;
                    case "SHA256":
                        algorithm = SHA256.Create();
                        break;
                    default:
                        throw new ArgumentException("Unsupported hash algorithm");
                }
                byte[] hashBytes = algorithm.ComputeHash(stream);
                return BitConverter.ToString(hashBytes).Replace("-", "").ToUpperInvariant();
            }
        }
    }
"@

function Get-RunningExeFiles {
    $exeFiles = @()
    $processes = Get-Process | Where-Object { $_.Path -and $_.Path.EndsWith(".exe") }
    foreach ($proc in $processes) {
        $exeFiles += $proc.Path
    }
    return $exeFiles
}

function Calculate-Hashes {
    param (
        [string]$filePath
    )

    $hashes = @{}
    try {
        $hashes["MD5"] = [HashUtilities]::ComputeHash($filePath, "MD5")
        $hashes["SHA1"] = [HashUtilities]::ComputeHash($filePath, "SHA1")
        $hashes["SHA256"] = [HashUtilities]::ComputeHash($filePath, "SHA256")
    }
    catch {
        Write-Host "Error calculating hashes for ${filePath}: $_"
        return $null
    }
    return $hashes
}

function Main {
    $exeFiles = Get-RunningExeFiles

    if ($exeFiles.Count -eq 0) {
        Write-Host "No running .exe files found."
        return
    }

    $outputDirectory = Read-Host "Please enter the directory to save hashes.txt"
    $outputPath = Join-Path -Path $outputDirectory -ChildPath "hashes.txt"

    foreach ($exeFile in $exeFiles) {
        Add-Content -Path $outputPath -Value "File: $exeFile"
        $hashes = Calculate-Hashes -filePath $exeFile
        if ($hashes) {
            Add-Content -Path $outputPath -Value "MD5: $($hashes['MD5'])"
            Add-Content -Path $outputPath -Value "SHA1: $($hashes['SHA1'])"
            Add-Content -Path $outputPath -Value "SHA256: $($hashes['SHA256'])"
        }
        Add-Content -Path $outputPath -Value ("-" * 60)
    }

    Write-Host "Hash values have been written to $outputPath"
}

Main

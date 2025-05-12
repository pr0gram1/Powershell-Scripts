# Input file containing text with IP addresses
$inputFile = "input.txt"

# Output file to save the nslookup results
$outputFile = "nslookup_results.txt"

# Regular expression pattern to match IP addresses
$ipRegex = "\b(?:\d{1,3}\.){3}\d{1,3}\b"

# Read the content of the input file
$content = Get-Content -Path $inputFile

# Find all unique IP addresses in the file
$ipAddresses = [regex]::Matches($content, $ipRegex) | ForEach-Object { $_.Value } | Sort-Object -Unique

# Initialize arrays for successful and failed lookups
$successfulLookups = @()
$failedLookups = @()

# Perform nslookup for each IP address
foreach ($ip in $ipAddresses) {
    Write-Output "Processing IP: $ip"
    try {
        # Perform nslookup
        $nslookupResult = nslookup $ip
        if ($nslookupResult -match "Name:") {
            # If lookup is successful, add to the successfulLookups array
            $successfulLookups += "IP: $ip`n$nslookupResult`n"
        } else {
            # If lookup fails, add to the failedLookups array
            $failedLookups += "IP: $ip`nLookup failed`n"
        }
    } catch {
        # Handle any exceptions and treat as a failed lookup
        $failedLookups += "IP: $ip`nError during lookup`n"
    }
}

# Sort both arrays alphabetically
$successfulLookups = $successfulLookups | Sort-Object
$failedLookups = $failedLookups | Sort-Object

# Combine the sorted results and write to the output file
Set-Content -Path $outputFile -Value $successfulLookups
Add-Content -Path $outputFile -Value $failedLookups

Write-Output "NSLookup results saved to $outputFile"
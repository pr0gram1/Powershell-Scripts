#### This command compares two CSV files using Compare-Object cmdlet and identifies differences
#### based on specific properites in the objects
#### Compare-object cmdlet has 2 properties that compare objects - ReferenceObject and DifferenceObject
#### Property DisplayName, Status will be displayed as data
#### <= Indicates ReferenceObject , => Indicates DifferenceObject
Compare-object -ReferenceObject (Import-Csv -Path "\locate\pathOfOldServices.csv") -DifferenceObject (Import-Csv -Path "\locate\pathOfNewServices.csv") -Property DisplayName, Status

### This command lists all the services that have status equal as "Running" and exports it afterwards
Get-Service | where {$_.Status -eq "Running"} | Export-Csv -path "\locate\pathOfNewServices.csv"
param (
	[ValidateNotNullorEmpty()]
	[string]$RepositoryRoot = "E:\KoviProjectSystem\SvnRepo",

	[parameter(Mandatory=$true)]
	[ValidateNotNullorEmpty()]
	[string]$RepositoryName,

	[switch]$Empty = $false
)

# Check that a directory with given name already exists.
$RepositoryPath = Join-Path $RepositoryRoot $RepositoryName
if (Test-Path $RepositoryPath) {
	throw "$RepositoryPath already exists"
}

# Initialize the repository
svnadmin create $RepositoryPath >$null
Remove-Item -Force -Confirm:$false -Recurse $RepositoryPath\conf
robocopy /IS /E conf $RepositoryPath\conf >$null
robocopy /IS /E hooks $RepositoryPath\hooks >$null

if (!$Empty.IsPresent) {
	# Construct the standard directory structure and commit.
	$TempDir = [System.Guid]::NewGuid().ToString()
	New-Item -Type Directory -Name $TempDir >$null
	cd $TempDir

	svn co -q svn://localhost/$RepositoryName
	cd $RepositoryName
	svn mkdir -q trunk branches tags
	svn ci -q -m "Repository initialized."

	# Cleanup
	Set-Location ..\..
	Remove-Item -Force -Recurse $TempDir
}

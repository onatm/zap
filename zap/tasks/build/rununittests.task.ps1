task RunUnitTests {
    $unitTestFilePathPattern = Get-Conventions unitTestFilePathPattern
    Run-NunitTests $unitTestFilePathPattern "UnitTest-Results.xml"
}

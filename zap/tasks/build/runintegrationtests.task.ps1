task RunIntegrationTests {
    $integrationTestFilePathPattern = Get-Conventions integrationTestFilePathPattern
    Run-NunitTests $integrationTestFilePathPattern "IntegrationTest-Results.xml"
}

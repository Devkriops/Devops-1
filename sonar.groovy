sonarProfileParser = { args, config ->
    def myProjectUrl = args['projectURL'] ?: utils.getSCMRepoURL()
    def myProjectName = args['projectname'] ?: utils.getProjectName()
    def myUser = args['user'] ?: config.user
    def myLanguage = args['language'] ?: 'py'
    def myQualityGate = args['qualitygate'] ?: config.qualitygate
    def mySources = args['sources'] ?: config.sources
    def myDebug = config.debug
    
    def expectedSonarProfileKeys = ['projectURL', 'projectname', 'user', 'qualitygate', 'sources', 'language']
    
    args.keySet().each { key ->
        if (!(key in expectedSonarProfileKeys)) {
            println "Unknown Sonar profile key: ${key}"
        }
    }
    
    return [
        projectUrl: myProjectUrl,
        projectName: myProjectName,
        user: myUser,
        language: myLanguage,
        qualitygate: myQualityGate,
        sources: mySources,
        debug: myDebug
    ]
}

sonarProfileParser = { 
    @param args = [:],
    @param config = [:]
    
    def myProjectUrl = args['projectURL'] ?: utils.getSCMRepoURL()
    def myProjectName = args['projectname'] ?: utils.getProjectName()
    def myUser = args['user'] ?: config.user
    def myLanguage = args['language'] ?: 'py'
    def myQualityGate = args['qualitygate'] ?: config.qualitygate
    def mySources = args['sources'] ?: config.sources
    def myDebug = config.debug
    
    def expectedSonarProfileKeys = ['projectURL', 'projectname', 'user', 'qualitygate', 'sources', 'language']
    
    args.keySet().each { key ->
        if (!(key in expectedSonarProfileKeys)) {
            println "Unknown Sonar profile key: ${key}"
        }
    }
    
    // Additional arguments
    def myBranchName = config.branchName
    def myFolder = config.folder
    def myClassDir = config.classDir
    def myScmType = config.scmType
    def myJunitReportPaths = config.junitReportPaths
    def myJacocoReportPaths = config.JacocoReportPaths
    def myEmails = config.emails
    def myProjectVersion = config.projectVersion
    
    // Call to javadeploymodule
    javadeploymodule(
        projectUrl: myProjectUrl,
        projectName: myProjectName,
        user: myUser,
        language: myLanguage,
        qualitygate: myQualityGate,
        sources: mySources,
        debug: myDebug,
        branchName: myBranchName,
        folder: myFolder,
        classDir: myClassDir,
        scmType: myScmType,
        junitReportPaths: myJunitReportPaths,
        JacocoReportPaths: myJacocoReportPaths,
        emails: myEmails,
        projectVersion: myProjectVersion
    )
}

# GitSemVerGradleVersionLabeler
A simple Gradle based Semantic Versioning (2.0) facilitator via smart Git tagging

## <ins>Command Examples</ins>

### Reckoned Version:

1. Printing the calculated version => `./gradlew printVersion`
 	* With setting Scope and Stage => `./gradlew -Preckon.scope=minor -Preckon.stage=rc printVersion`
1. Stamping (creating a local tag) a calculated version => `./gradlew stampVersion`
	* With setting Scope and Stage => `./gradlew -Preckon.scope=minor -Preckon.stage=rc stampVersion`
1. Publishing (pushing a tag to remote repository) a calculated version => `./gradlew -Dorg.ajoberstar.grgit.auth.username=<ACCESS_TOKEN> publishVersion`
	* With setting Scope and Stage => `./gradlew -Preckon.scope=minor -Preckon.stage=rc -Dorg.ajoberstar.grgit.auth.username=<ACCESS_TOKEN> publishVersion`

### Designated (and applicable (which takes into account both reckoned and designated flavors)) Version:

1. Printing the applicable version => `./gradlew printApplicableVersion`
 	* With setting designated version tag and message => `./gradlew -Pdemo4echo.designatedTagName=9.9.9 -Pdemo4echo.designatedTagMessage="Version for Demo" printApplicableVersion`
1. Stamping (creating a local tag) an applicable version => `./gradlew stampApplicableVersion`
	* With setting designated version tag and message => `./gradlew -Pdemo4echo.designatedTagName=9.9.9 -Pdemo4echo.designatedTagMessage="Version for Demo" stampApplicableVersion`
1. Publishing (pushing a tag to remote repository) an applicable version => `./gradlew -Dorg.ajoberstar.grgit.auth.username=<ACCESS_TOKEN> publishApplicableVersion`
	* With setting designated version tag and message => `./gradlew -Preckon.scope=minor -Pdemo4echo.designatedTagName=9.9.9 -Pdemo4echo.designatedTagMessage="Version for Demo" -Dorg.ajoberstar.grgit.auth.username=<ACCESS_TOKEN> publishApplicableVersion`

### Recent Version:

1. Print the most recent version => `./gradlew printLatestVersion`

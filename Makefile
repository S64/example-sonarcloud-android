check-envs:
	@test -n "${SONAR_TOKEN}"
	@test -n "${GITHUB_TOKEN}"
	@test -n "${PULL_REQUEST_ID}"
	test -n "${BRANCH_NAME}"
	test -n "${TARGET_BRANCH_NAME}"

sonarcloud: check-envs
	@./gradlew sonarqube \
		-Dsonar.projectKey=example-sonarcloud-android \
		-Dsonar.organization=s64-github \
		-Dsonar.host.url=https://sonarcloud.io \
		-Dsonar.login=${SONAR_TOKEN} \
		-Dsonar.pullrequest.branch=${BRANCH_NAME} \
		-Dsonar.pullrequest.key=${PULL_REQUEST_ID} \
		-Dsonar.pullrequest.base=${TARGET_BRANCH_NAME} \
		-Dsonar.pullrequest.provider=github \
		-Dsonar.pullrequest.github.repository=S64/example-sonarcloud-android \
		-Dsonar.pullrequest.github.token.secured=${GITHUB_TOKEN}
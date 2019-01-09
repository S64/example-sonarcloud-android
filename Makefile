check-envs:
	@test -n "${SONAR_TOKEN}"
	@test -n "${GITHUB_TOKEN}"
	@test -n "${PULL_REQUEST_ID}"
	test -n "${BRANCH_NAME}"

sonarcloud: check-envs
	@./gradlew sonarqube \
		-Dsonar.projectKey=example-sonarcloud-android \
		-Dsonar.organization=s64-github \
		-Dsonar.host.url=https://sonarcloud.io \
		-Dsonar.login=${SONAR_TOKEN} \
		-Dsonar.github.oauth=${GITHUB_TOKEN} \
		-Dsonar.github.repository='S64/example-sonarcloud-android' \
		-Dsonar.github.pullRequest=${PULL_REQUEST_ID} \
		-Dsonar.branch.name=${BRANCH_NAME}

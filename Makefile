check-envs:
	@test -n "${SONAR_TOKEN}"
	@test -n "${GITHUB_TOKEN}"
	test -n "${PULL_REQUEST_ID}"
	test -n "${BRANCH_NAME}"
	test -n "${TARGET_BRANCH_NAME}"
	test -n "${SONAR_ORGANIZATION}"
	test -n "${SONAR_PROJECT_KEY}"
	test -n "${REPOSITORY_SLUG}"

sonarcloud: check-envs
	@./gradlew sonarqube --info \
         -Dsonar.organization=${SONAR_ORGANIZATION} \
         -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
         -Dsonar.host.url=https://sonarcloud.io \
         -Dsonar.pullrequest.github.token.secured=${GITHUB_TOKEN} \
         -Dsonar.pullrequest.base=${TARGET_BRANCH_NAME} \
         -Dsonar.pullrequest.branch=${BRANCH_NAME} \
         -Dsonar.pullrequest.key=${PULL_REQUEST_ID} \
         -Dsonar.pullrequest.provider=github \
         -Dsonar.pullrequest.github.repository=${REPOSITORY_SLUG} \
         -Dsonar.login=${SONAR_TOKEN}

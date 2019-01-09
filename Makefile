check-envs: check-env-sonar_token check-env-github_token check-env-branch_name check-env-pr_id check-env-target_branch_name check-env-sonar_org check-env-sonar_project_key check-env-repository_slug

check-env-sonar_token:
	@test -n "${SONAR_TOKEN}"

check-env-github_token:
	@test -n "${GITHUB_TOKEN}"

check-env-branch_name:
	test -n "${BRANCH_NAME}"

check-env-pr_id:
	test -n "${PULL_REQUEST_ID}"

check-env-target_branch_name:
	test -n "${TARGET_BRANCH_NAME}"

check-env-sonar_org:
	test -n "${SONAR_ORGANIZATION}"

check-env-sonar_project_key:
	test -n "${SONAR_PROJECT_KEY}"

check-env-repository_slug:
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

CIRCLE_PR_NUMBER?=$(shell echo $${CIRCLE_PULL_REQUEST\#\#*/})# https://blog.s64.jp/entry/makefile_gh-pr-num_extractor
TARGET_BRANCH_NAME:=master
REPOSITORY_SLUG:=${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}
SONAR_ORGANIZATION:=s64-github
SONAR_PROJECT_KEY:=example-sonarcloud-android

check-envs-pullreq: check-env-sonar_token check-env-github_token check-env-branch_name check-env-pr_id check-env-target_branch_name check-env-sonar_org check-env-sonar_project_key check-env-repository_slug
check-envs-merge: check-env-sonar_token check-env-branch_name check-env-sonar_org check-env-sonar_project_key

check-env-sonar_token:
	@test -n "${SONAR_TOKEN}"

check-env-github_token:
	@test -n "${GITHUB_TOKEN}"

check-env-branch_name:
	test -n "${CIRCLE_BRANCH}"

check-env-pr_id:
	test -n "${CIRCLE_PR_NUMBER}"

check-env-target_branch_name:
	test -n "${TARGET_BRANCH_NAME}"

check-env-sonar_org:
	test -n "${SONAR_ORGANIZATION}"

check-env-sonar_project_key:
	test -n "${SONAR_PROJECT_KEY}"

check-env-repository_slug:
	test -n "${REPOSITORY_SLUG}"

sonarcloud:
	@if ( [ ! -z "${CIRCLE_PULL_REQUEST}" ] ); then \
		echo 'Pull Request detected.'; \
		$(MAKE) sonarcloud-pullreq; \
	elif ( [ "${TARGET_BRANCH_NAME}" = "${CIRCLE_BRANCH}" ] ); then \
		echo 'Merge detected.'; \
		$(MAKE) sonarcloud-merge; \
	else \
		echo 'NOTE: This workflow is not pullreq. Do nothing.'; \
	fi

sonarcloud-pullreq: check-envs-pullreq
	@./gradlew sonarqube --info \
         -Dsonar.organization=${SONAR_ORGANIZATION} \
         -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
         -Dsonar.host.url=https://sonarcloud.io \
         -Dsonar.pullrequest.github.token.secured=${GITHUB_TOKEN} \
         -Dsonar.pullrequest.base=${TARGET_BRANCH_NAME} \
         -Dsonar.pullrequest.branch=${CIRCLE_BRANCH} \
         -Dsonar.pullrequest.key=${CIRCLE_PR_NUMBER} \
         -Dsonar.pullrequest.provider=github \
         -Dsonar.pullrequest.github.repository=${REPOSITORY_SLUG} \
         -Dsonar.login=${SONAR_TOKEN} \
         -Dsonar.scm.disabled=true

sonarcloud-merge: check-envs-merge
	@./gradlew sonarqube --info \
		-Dsonar.organization=${SONAR_ORGANIZATION} \
		-Dsonar.projectKey=${SONAR_PROJECT_KEY} \
		-Dsonar.host.url=https://sonarcloud.io \
		-Dsonar.branch.name=${CIRCLE_BRANCH} \
		-Dsonar.login=${SONAR_TOKEN} \
		-Dsonar.scm.disabled=true

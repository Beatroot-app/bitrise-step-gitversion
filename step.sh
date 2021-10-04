#!/bin/bash
set -ex

# echo "This is the value specified for the input 'example_step_input': ${example_step_input}"

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
echo "Changing directory to ${directory}"
cd ${directory}
# echo "Selected format: ${version_format}"

gitversion=$(gitversion /output json)
mmp=$(echo -n $gitversion | jq .MajorMinorPatch | tr -d '"')
semver=$(echo -n $gitversion | jq .SemVer | tr -d '"')
prt=$(echo -n $gitversion | jq .PreReleaseTag | tr -d '"')

echo "APP_VERSION_MMP: $mmp"
echo "APP_VERSION_SEMVER: $semver"
echo "APP_VERSION_PRERELEASETAG: $prt"

echo -n $mmp | envman add --key APP_VERSION_MMP
echo -n $semver | envman add --key APP_VERSION_SEMVER
echo -n $prt | envman add --key APP_VERSION_PRERELEASETAG

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.

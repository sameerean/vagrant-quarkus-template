#!/bin/bash

packageToFolderString() {
	echo $1 | sed -r 's/[.]+/\//g'
}

echo *****************************************
echo *******  Quarkus Project Builder  *******
echo *****************************************\n

read -p 'Your application name: ' -e -i 'Rest JSON Quick Start' applicationName

read -p 'projectGroupId: ' -e -i 'org.acme.jsonquickstart' projectGroupId

read -p 'projectArtifactId: ' -e -i 'rest-json-quickstart' projectArtifactId

read -p 'HTTP Port: ' -e -i '8080' httpPort

read -p 'Mapped HTTP Port: ' -e -i '8180' mappedHttpPort

read -p 'Primary Rest Resource class: ' -e -i 'org.acme.jsonquickstart.rest.json.HelloResource' resourceClassName

read -p 'Primary Rest Resource url: ' -e -i '/api/hello' resourceUrl


echo Generating Quarkus project with the wollowing variables:
echo applicationName = $applicationName
echo projectGroupId = $projectGroupId
echo projectArtifactId = $projectArtifactId
echo httpPort = $httpPort
echo mappedHttpPort = $mappedHttpPort
echo resourceClassName = $resourceClassName
echo resourceUrl = $resourceUrl


mvn io.quarkus:quarkus-maven-plugin:1.3.2.Final:create \
    -DprojectGroupId=$projectGroupId \
    -DprojectArtifactId=$projectArtifactId \
    -DclassName="$resourceClassName" \
    -Dpath="$resourceUrl" \
    -Dextensions="resteasy-jackson"

cd $projectArtifactId

./mvnw quarkus:add-extension -Dextensions="openapi, resteasy-jsonb"
./mvnw quarkus:add-extension -Dextensions="config-yaml"

cd ..

javaPackageRoot=$(packageToFolderString $projectGroupId)
applicationFile=$projectArtifactId/src/main/java/$javaPackageRoot/Application.java
applicationLifeCycleFile=$projectArtifactId/src/main/java/$javaPackageRoot/ApplicationLifeCycle.java
applicationYamlFile=$projectArtifactId/src/main/resources/application.yml
echo javaPackageRoot = $javaPackageRoot
echo applicationFile = $applicationFile
echo applicationLifeCycleFile = $applicationLifeCycleFile
echo applicationYamlFile = $applicationYamlFile

cp _resources/Application.java_$ $applicationFile
sed -i "s/{projectGroupId}/$projectGroupId/g" "$applicationFile"
sed -i "s/{applicationName}/$applicationName/g" "$applicationFile"
sed -i "s/{mappedHttpPort}/$mappedHttpPort/g" "$applicationFile"

cp _resources/ApplicationLifeCycle.java_$ $applicationLifeCycleFile
sed -i "s/{projectGroupId}/$projectGroupId/g" "$applicationLifeCycleFile"
sed -i "s/{applicationName}/$applicationName/g" "$applicationFile"

cp _resources/application.yml_$ $applicationYamlFile
sed -i "s/{httpPort}/$httpPort/g" "$applicationYamlFile"


#!/bin/bash

echo *****************************************
echo *******  Quarkus Project Builder  *******
echo *****************************************\n

read -p 'projectGroupId[eg: org.acme]: ' projectGroupId

read -p 'projectArtifactId[eg: rest-json-quickstart]: ' projectArtifactId

read -p 'Primary Rest Resource class [eg: org.acme.rest.json.HelloResource]: ' resourceClassName

read -p 'Primary Rest Resource url [eg: /hello]: ' resourceUrl


echo Generating Quarkus project with the wollowing variables:
echo projectGroupId = $projectGroupId
echo projectArtifactId = $projectArtifactId
echo resourceClassName = $resourceClassName
echo resourceUrl = $resourceUrl


mvn io.quarkus:quarkus-maven-plugin:1.3.2.Final:create \
    -DprojectGroupId=$projectGroupId \
    -DprojectArtifactId=$projectArtifactId \
    -DclassName="$resourceClassName" \
    -Dpath="$resourceUrl" \
    -Dextensions="resteasy-jackson"

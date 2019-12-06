{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ecr-cred-helper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ecr-cred-helper.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ecr-cred-helper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ecr-cred-helper.labels" -}}
app.kubernetes.io/name: {{ include "ecr-cred-helper.name" . }}
helm.sh/chart: {{ include "ecr-cred-helper.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "ecr-cred-helper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "ecr-cred-helper.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the role to use
*/}}
{{- define "ecr-cred-helper.roleName" -}}
{{- if .Values.role.create -}}
    {{ default (include "ecr-cred-helper.fullname" .) .Values.role.name }}
{{- else -}}
    {{ default "default" .Values.role.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the role binding to use
*/}}
{{- define "ecr-cred-helper.roleBindingName" -}}
{{- if .Values.roleBinding.create -}}
    {{ default (include "ecr-cred-helper.fullname" .) .Values.roleBinding.name }}
{{- else -}}
    {{ default "default" .Values.roleBinding.name }}
{{- end -}}
{{- end -}}

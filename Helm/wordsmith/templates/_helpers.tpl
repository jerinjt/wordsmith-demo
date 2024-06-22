{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wordsmith.fullname" -}}
{{- $name := .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- define "wordsmith.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Common labels
*/}}
{{- define "wordsmith.labels" -}}
helm.sh/chart: {{ include "wordsmith.chart" . }}
{{ include "wordsmith.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/AppVersion: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}

{{- define "wordsmith.selectorLabels" -}}
app.kubernetes.io/name: "wordsmith"
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}
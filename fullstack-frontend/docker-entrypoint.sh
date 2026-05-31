#!/bin/sh
set -e

# ---------------------------------------------------------------------------
# Runtime environment variable injection for Vite apps in Kubernetes.
#
# Vite bakes VITE_* vars into the JS bundle at build time. The Dockerfile
# sets each var to a unique placeholder string. This script replaces those
# placeholders with the actual values from K8s env vars before nginx starts.
# ---------------------------------------------------------------------------

replace_in_js() {
  local placeholder="$1"
  local value="$2"
  find /usr/share/nginx/html -name '*.js' \
    -exec sed -i "s|${placeholder}|${value}|g" {} \;
}

replace_in_js "VITE_AUTH0_DOMAIN_PLACEHOLDER"        "${VITE_AUTH0_DOMAIN}"
replace_in_js "VITE_AUTH0_AUDIENCE_PLACEHOLDER"      "${VITE_AUTH0_AUDIENCE}"
replace_in_js "VITE_AUTH0_FO_CLIENT_ID_PLACEHOLDER"  "${VITE_AUTH0_FO_CLIENT_ID}"
replace_in_js "VITE_AUTH0_CLIENT_ID_PLACEHOLDER"     "${VITE_AUTH0_CLIENT_ID}"
replace_in_js "VITE_AUTH0_CLIENT_SECRET_PLACEHOLDER" "${VITE_AUTH0_CLIENT_SECRET}"
replace_in_js "VITE_LOCAL_API_URL_PLACEHOLDER"       "${VITE_LOCAL_API_URL}"
replace_in_js "VITE_STRIPE_PUBLIC_KEY_PLACEHOLDER"   "${VITE_STRIPE_PUBLIC_KEY}"

exec "$@"

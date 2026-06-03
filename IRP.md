# Incident Response Plan

This plan describes how maintainers coordinate security and operational incidents for this project.

## Scope

Use this plan for suspected vulnerabilities, compromised release credentials, malicious dependency activity, or other events that may affect users of this project.

## Contacts

Report security issues using the process in [SECURITY.md](SECURITY.md). Maintainers should keep incident coordination private until disclosure is appropriate.

## Triage

1. Confirm whether the report affects a released artifact, source repository, CI system, package registry account, or maintainer credential.
2. Assign one maintainer as incident lead.
3. Record the affected versions, known exposure window, and current mitigation status.
4. Decide whether package publishing, CI secrets, or repository automation should be temporarily disabled.

## Containment

Rotate exposed credentials, revoke compromised tokens, disable affected automation, and remove malicious artifacts where possible. If a published package is affected, coordinate with the package registry before deleting or yanking releases.

## Remediation

Prepare the minimal fix, add regression coverage when practical, and release patched versions. Prefer a clear advisory over silent fixes when users need to take action.

## Disclosure

Publish an advisory that includes affected versions, fixed versions, impact, mitigation steps, and credits when appropriate. Link the advisory from the changelog or release notes.

## Follow-up

After closure, review what failed, update this plan, and add preventive checks to CI or release automation where possible.

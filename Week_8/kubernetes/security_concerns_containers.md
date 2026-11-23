# Mitigating Security Concerns with Containers

## Main Measures

- Use maintained images: choose trusted, supported images receiving security patches.
- Enable registry scanning: automatically check stored images for known vulnerabilities.
- Run your own scans: scan images during development and CI/CD, e.g. using Trivy.
- Run as non-root: limit the damage if an application is compromised; avoid privileged containers.
- Monitor and log activity: detect suspicious processes, unexpected network traffic, and failures.

## Maintained container Images

### What are they?

- Container images regularly updated and managed by a maintainer.
- Maintainers may be organisations, communities, or individuals.
- Updates include security patches, dependency updates, and bug fixes.
- Designed to provide a reliable foundation for containerised applications.

### Why use them?

- Applications inherit the software and vulnerabilities in their base image.
- Maintained images receive patches that help reduce known security risks.
- Trusted publishers provide greater confidence in an image’s origin.

## Advantages

- Security patches: fixes for known vulnerabilities.
- Reduced maintenance: maintainers update base components.
- Reliability: established maintenance and release processes.
- Documentation: guidance on configuration and usage.

## Limitations

- Not vulnerability-free: maintained images still need security scanning.
- Reliance on maintainers: fixes depend on their response times.
- Compatibility issues: updates may affect application behaviour.
- Updates require action: running containers do not automatically receive patches.

## Good Practices

- Use trusted sources, such as Docker Official Images or Verified Publishers.
- Choose actively maintained, supported versions.
- Avoid abandoned images and unsupported software.
- Prefer minimal images with fewer unnecessary packages.
- Regularly pull updates, rebuild images, and recreate containers.
- Test updated images before deployment.
- Scan images for known vulnerabilities.

## Applying Updates

1. Pull the updated image.
2. Rebuild your application image if it uses that base.
3. Scan and test the result.
4. Recreate containers using the updated image.

## Key Point

> Maintained images reduce security risks, but regular updates, testing,
> scanning, and redeployment



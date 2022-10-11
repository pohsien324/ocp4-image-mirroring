# ocp4-image-mirroring
Bash scripts make the procedure of 
These scripts automate the procedure of Container Images tagging and pushing, and generate the specific [`ImageContentSourcePolicy`](https://docs.openshift.com/container-platform/4.5/openshift_images/image-configuration.html#images-configuration-registry-mirror_image-configuration) for OpenShift 4 Cluster.

## Quick Start
1. Clone the repository.
```bash=
git clone https://github.com/pohsienshih/ocp4-image-mirroring.git
```

2. Fill the specific images which you want to mirror into `image_list` file.
```bash=
vim image_list
```

3. Modify the `NEW_REGISTRY` to your private registry.

```bash=
vim 2_tag_push_image.sh
vim 3_generate_imagecontentpolicy.sh
```
```bash=
NEW_REGISTRY="private-registry.example.com"
```

4. Pull the images to your local host.
```bash=
./1_pull_image.sh
```
> Skip this step if you don't need to pull the image.

4. Push the images to your private registry.
```bash=
./2_tag_push_image.sh
```
> Skip this step if you don't need to push the image.

5. Generate the specific `ImageContentSourcePolicy`. Use the output to create an `ImageContentSourcePolicy` object.
```bash=
./3_generate_imagecontentpolicy.sh
```
Output:
```bash=
Generate Image Source Content Policy...

Complete! Use the following to create an ImageContentSourcePolicy:



apiVersion: operator.openshift.io/v1alpha1
kind: ImageContentSourcePolicy
metadata:
  name: custom-image-mirror
spec:
  repositoryDigestMirrors:
  - mirrors:
    - private-registry.example.com/sig-storage/csi-attacher
    source: k8s.gcr.io/sig-storage/csi-attacher
  - mirrors:
    - private-registry.example.com/sig-storage/csi-node-driver-registrar
    source: k8s.gcr.io/sig-storage/csi-node-driver-registrar
  - mirrors:
    - private-registry.example.com/sig-storage/csi-provisioner
    source: k8s.gcr.io/sig-storage/csi-provisioner
  - mirrors:
    - private-registry.example.com/sig-storage/csi-resizer
    source: k8s.gcr.io/sig-storage/csi-resizer
  - mirrors:
    - private-registry.example.com/sig-storage/csi-snapshotter
    source: k8s.gcr.io/sig-storage/csi-snapshotter
  - mirrors:
    - private-registry.example.com/cephcsi/cephcsi
    source: quay.io/cephcsi/cephcsi
```


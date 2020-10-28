# ocp4-image-mirroring
These scripts help you push your Container Images to your private registry, and generate the specific [`ImageContentSourcePolicy`](https://docs.openshift.com/container-platform/4.5/openshift_images/image-configuration.html#images-configuration-registry-mirror_image-configuration) for your OpenShift 4 Cluster.

## How to 
1. Clone the repository.
```bash=
git clone https://github.com/pohsienshih/ocp4-image-mirroring.git
```

2. Fill the Images which you want to mirror into `image_list` file.
```bash=
vim image_list
```

3. Modify the `NEW_REGISTRY` to your private registry.

```bash=
vim 2_tag_push_image.sh
vim 3_generate_imagecontentpolicy.sh
```
```bash=
NEW_REGISTRY="Your Private Registry"
```

4. Pull the images to your local host.
```bash=
bash 1_pull_image.sh
```
> Skip this step if you don't need to pull the image.

4. Push the images to your private registry.
```bash=
bash 2_tag_push_image.sh
```
> Skip this step if you don't need to push the image.

5. Generate the `ImageContentSourcePolicy`. Use the output to create an `ImageContentSourcePolicy` object.
```bash=
bash 3_generate_imagecontentpolicy.sh
```


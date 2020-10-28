NEW_REGISTRY="Your Private Registry"
#--------------------------------------------


printf "\nGenerate Image Source Content Policy...\n\n"
printf "Complete! Use the following to create an ImageContentSourcePolicy:\n\n\n\n"



cat << EOF
apiVersion: operator.openshift.io/v1alpha1
kind: ImageContentSourcePolicy
metadata:
  name: csi-image
spec:
  repositoryDigestMirrors:
EOF



while IFS= read -r line; do
   ORGIN_REGISTRY=$(echo $line | sed 's/\(\/.*\)//g') 
   SOURCE_REGISTRY=$(echo $line | sed 's/\(.*\):\(.*\)/\1/')

   MIRROR_REGISTRY=$(echo $line | sed "s/$ORGIN_REGISTRY/$NEW_REGISTRY/g" |   sed 's/\(.*\):\(.*\)/\1/' )
   printf "%b\n" "  - mirrors:"
   printf "%b\n" "    - $MIRROR_REGISTRY"
   printf "%b\n" "    source: $SOURCE_REGISTRY"
done < image_list



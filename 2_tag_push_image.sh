NEW_REGISTRY="Your Private Registry"
#------------------------------------------------



podman login $NEW_REGISTRY

while IFS= read -r line; do
   ORGIN_REGISTRY=$(echo $line | sed 's/\(\/.*\)//g')

   # Tag the Image
   NEW_IMAGE=$(echo $line | sed "s/$ORGIN_REGISTRY/$NEW_REGISTRY/g")
   podman tag $line $NEW_IMAGE
   
   # Push the Image
   podman push $NEW_IMAGE

   echo "ORIGIN IMAGE: "$line  
   echo "NEW IMAGE: "$NEW_IMAGE  
   printf "\n\n"
done < image_list

echo "Compete"

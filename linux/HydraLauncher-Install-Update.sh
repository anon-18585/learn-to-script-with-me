read -r -p "Do you want to update/install the Hydra Launcher? (y/n): " choice

case $choice in
    y|Y)
        echo "The Hydra Launcher update script is running..."
        curl -fsSL https://hydra.la/install.sh | bash
        ;;
    n|N)
        echo "Update cancelled."
        ;;
    *)
        echo "Invalid choice. Please enter 'y' or 'n'."
        ;;
esac
echo "Done."

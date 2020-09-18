function install_flycut() {
    write_info "Installing Flycut package..."

    if [[ ! -d "${apps_dir}/Flycut.app" ]]; then
        write_info "Installing Flycut..."
        brew cask list flycut &>/dev/null || brew cask install flycut
        write_success "Done!"
        write_blank_line
    else
        write_progress "Flycut is already installed"
        write_success "Done!"
        write_blank_line
    fi
}

function uninstall_flycut() {
    write_info "Uninstalling Flycut package..."

    write_info "Uninstalling Flycut..."
    brew cask uninstall flycut || { write_warning "WARNING! Flycut is not installed and cannot be uninstalled. Continuing on."; }
    write_success "Done!"
    write_blank_line
}

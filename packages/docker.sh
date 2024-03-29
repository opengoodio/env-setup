install_docker() {
    write_info "Installing Docker package..."

    if [[ ! -d "${docker_app}" ]]; then
        write_info "Downloading Docker..."
        cd_push "${downloads_dir}"
        curl -o docker.dmg https://desktop.docker.com/mac/main/arm64/Docker.dmg
        write_success "Done!"
        write_blank_line

        write_info "Attaching Docker image..."
        sudo hdiutil attach docker.dmg
        write_success "Done!"
        write_blank_line

        write_info "Installing Docker..."
        cp -a "${volumes_dir}"/Docker/Docker.app "${docker_app}"
        open "${docker_app}"
        echo -e "Waiting for user to complete interactive installation. When done, press [ENTER]:"
        read -r complete
        write_success "Done!"
        write_blank_line

        write_info "Unmounting Docker image..."
        sudo hdiutil unmount "${volumes_dir}"/Docker
        write_success "Done!"
        write_blank_line

        write_info "Deleting Docker image..."
        rm -f docker.dmg
        cd_pop
        write_success "Done!"
        write_blank_line

        write_info "Installing Docker Bash parameter completion..."
        sudo mkdir -p /usr/local/etc/bash_completion.d
        cd_push /usr/local/etc/bash_completion.d
        ln -fs "${docker_resources_dir}"/etc/docker.bash-completion
        ln -fs "${docker_resources_dir}"/etc/docker-machine.bash-completion
        ln -fs "${docker_resources_dir}"/etc/docker-compose.bash-completion
        cd_pop
        write_success "Done!"
        write_blank_line
    else
        write_progress "Docker is already installed..."
        write_success "Done!"
        write_blank_line
    fi
}

uninstall_docker() {
    write_info "Uninstalling Docker package..."

    write_info "Uninstalling Docker installation directories..."
    rm -Rf "${containers_dir}"/com.docker.*
    write_success "Done!"
    write_blank_line

    write_info "Uninstalling Docker..."
    rm -Rf "${docker_app}" || { write_warning "WARNING! Docker is not installed and cannot be uninstalled. Continuing on."; }
    write_success "Done!"
    write_blank_line
}

# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
pin "@fortawesome/fontawesome-free", to: "@fortawesome--fontawesome-free.js" # @6.7.1
pin "jquery-easing" # @0.0.1
pin "jquery" # @3.7.1
pin "sb-admin-2", to: "sb-admin-2.min.js"

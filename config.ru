require './config/environment'
require 'pry'


if ActiveRecord::Base.connection.migration_context.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use PowerController
use BuildingController
use ArchatypeController
use UserController
use LocationController
use CharacterController
run ApplicationController
require_relative '.config/environment'

if ActiveRecord::migrator.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue'
end

use Rack::MethodOverride

use LocationController
use CharicterController
run ApplicationController
class ApplicationController < ActionController::Base

  private
  def after_sign_in_path_for(namespace_or_scope)
      if namespace_or_scope.is_a?(Admin)
         admin_top_path
      else
         current_user
      end
  end

  def after_sign_out_path_for(namespace_or_scope)
      if namespace_or_scope == :public
         root_path
      elsif
         namespace_or_scope == :admin
         new_admin_session_path
      else
         root_path
      end
  end

 end
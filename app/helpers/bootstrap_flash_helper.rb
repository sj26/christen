module BootstrapFlashHelper
  BOOTSTRAP_FLASH = Hash.new { |hash, key| key }.merge!(notice: :success, alert: :error).freeze

  def bootstrap_flashes
    if flash.present?
      content_tag :aside, class: "flashes container" do
        safe_join(flash.keys.map do |key|
          content_tag(:div, class: "alert fade in alert-#{BOOTSTRAP_FLASH[key]}") do
            link_to("×", "#", class: "close", data: {dismiss: "alert"}) << flash[key]
          end
        end)
      end
    end
  end
end

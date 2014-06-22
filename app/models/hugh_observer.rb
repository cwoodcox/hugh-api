# I chose an observer class as a kind of stand-in for something like a queueing
# service or other background processing service. That way we can keep all the
# calls to the Spark API in a single area, and eventually wrap retry and other
# exceptions to normal flow in that object/service.
#
# Normally, I'd want to take all the logic that calculates the URLs and the
# posted data and drop it in its own class as well (probably the same class used
# for the background processing), but for the sake of brevity it remains here.

class HughObserver < ActiveRecord::Observer
  def after_save record
    record.spark_api.post "#{record.spark_core_id}/command", { params: record.spark_color_string }
  end
end

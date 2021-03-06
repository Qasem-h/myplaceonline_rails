class SunExposuresController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["sun_exposures.exposure_start DESC"]
    end

    def obj_params
      params.require(:sun_exposure).permit(:exposure_start, :exposure_end, :sunscreened_body_parts, :uncovered_body_parts, :sunscreen_type)
    end
end

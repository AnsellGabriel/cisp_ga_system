import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
    static targets = ["provinceSelect", "municipalitySelect", "barangaySelect" ] 

    search_province(event) {
        console.log("hello")
        let region_id  = event.target.selectedOptions[0].value
        let target = this.provinceSelectTarget.id

    get(`/geo_regions/${region_id}/selected?target=${target}`, {
        responseKind: "turbo-stream" 
    })
    }
    search_municipality(event) {
        
        let province_id  = event.target.selectedOptions[0].value
        let target = this.municipalitySelectTarget.id

    get(`/geo_provinces/${province_id}/selected?target=${target}`, {
        responseKind: "turbo-stream" 
    })
    }
    search_barangay(event) {
        
        let municipality_id  = event.target.selectedOptions[0].value
        let target = this.barangaySelectTarget.id

    get(`/geo_municipalities/${municipality_id}/selected?target=${target}`, {
        responseKind: "turbo-stream" 
    })
    }
}
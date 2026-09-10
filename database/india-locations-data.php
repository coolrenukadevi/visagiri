<?php
declare(strict_types=1);

/**
 * Factual reference data only: state/UT name, capital, zone, and a short
 * list of well-known major cities. No office, staffing or service-area
 * claims live here — those are handled honestly in the page template
 * (Videshia serves applicants nationally via online consultation; we do
 * not claim a physical branch in every state).
 * Row shape: [slug, name, type, capital, zone, majorCities[]]
 */
function all_india_locations_data(): array
{
    return [
        // States
        ['andhra-pradesh', 'Andhra Pradesh', 'State', 'Amaravati', 'South', ['Visakhapatnam', 'Vijayawada', 'Guntur', 'Nellore', 'Tirupati']],
        ['arunachal-pradesh', 'Arunachal Pradesh', 'State', 'Itanagar', 'Northeast', ['Itanagar', 'Naharlagun', 'Pasighat', 'Tawang']],
        ['assam', 'Assam', 'State', 'Dispur', 'Northeast', ['Guwahati', 'Silchar', 'Dibrugarh', 'Jorhat', 'Tezpur']],
        ['bihar', 'Bihar', 'State', 'Patna', 'East', ['Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Darbhanga']],
        ['chhattisgarh', 'Chhattisgarh', 'State', 'Raipur', 'Central', ['Raipur', 'Bhilai', 'Bilaspur', 'Durg', 'Korba']],
        ['goa', 'Goa', 'State', 'Panaji', 'West', ['Panaji', 'Margao', 'Vasco da Gama', 'Mapusa']],
        ['gujarat', 'Gujarat', 'State', 'Gandhinagar', 'West', ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Gandhinagar']],
        ['haryana', 'Haryana', 'State', 'Chandigarh', 'North', ['Gurugram', 'Faridabad', 'Panipat', 'Karnal', 'Hisar']],
        ['himachal-pradesh', 'Himachal Pradesh', 'State', 'Shimla', 'North', ['Shimla', 'Dharamshala', 'Mandi', 'Solan', 'Kullu']],
        ['jharkhand', 'Jharkhand', 'State', 'Ranchi', 'East', ['Ranchi', 'Jamshedpur', 'Dhanbad', 'Bokaro', 'Deoghar']],
        ['karnataka', 'Karnataka', 'State', 'Bengaluru', 'South', ['Bengaluru', 'Mysuru', 'Mangaluru', 'Hubballi', 'Belagavi']],
        ['kerala', 'Kerala', 'State', 'Thiruvananthapuram', 'South', ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Thrissur', 'Kollam']],
        ['madhya-pradesh', 'Madhya Pradesh', 'State', 'Bhopal', 'Central', ['Bhopal', 'Indore', 'Jabalpur', 'Gwalior', 'Ujjain']],
        ['maharashtra', 'Maharashtra', 'State', 'Mumbai', 'West', ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad']],
        ['manipur', 'Manipur', 'State', 'Imphal', 'Northeast', ['Imphal', 'Thoubal', 'Bishnupur']],
        ['meghalaya', 'Meghalaya', 'State', 'Shillong', 'Northeast', ['Shillong', 'Tura', 'Jowai']],
        ['mizoram', 'Mizoram', 'State', 'Aizawl', 'Northeast', ['Aizawl', 'Lunglei', 'Champhai']],
        ['nagaland', 'Nagaland', 'State', 'Kohima', 'Northeast', ['Kohima', 'Dimapur', 'Mokokchung']],
        ['odisha', 'Odisha', 'State', 'Bhubaneswar', 'East', ['Bhubaneswar', 'Cuttack', 'Rourkela', 'Berhampur', 'Sambalpur']],
        ['punjab', 'Punjab', 'State', 'Chandigarh', 'North', ['Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala', 'Mohali']],
        ['rajasthan', 'Rajasthan', 'State', 'Jaipur', 'North', ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer']],
        ['sikkim', 'Sikkim', 'State', 'Gangtok', 'Northeast', ['Gangtok', 'Namchi', 'Gyalshing']],
        ['tamil-nadu', 'Tamil Nadu', 'State', 'Chennai', 'South', ['Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli', 'Salem']],
        ['telangana', 'Telangana', 'State', 'Hyderabad', 'South', ['Hyderabad', 'Warangal', 'Nizamabad', 'Karimnagar']],
        ['tripura', 'Tripura', 'State', 'Agartala', 'Northeast', ['Agartala', 'Udaipur', 'Dharmanagar']],
        ['uttar-pradesh', 'Uttar Pradesh', 'State', 'Lucknow', 'North', ['Lucknow', 'Kanpur', 'Noida', 'Ghaziabad', 'Agra', 'Varanasi']],
        ['uttarakhand', 'Uttarakhand', 'State', 'Dehradun', 'North', ['Dehradun', 'Haridwar', 'Haldwani', 'Rishikesh']],
        ['west-bengal', 'West Bengal', 'State', 'Kolkata', 'East', ['Kolkata', 'Howrah', 'Durgapur', 'Siliguri', 'Asansol']],

        // Union Territories
        ['andaman-and-nicobar-islands', 'Andaman and Nicobar Islands', 'Union Territory', 'Port Blair', 'South', ['Port Blair']],
        ['chandigarh', 'Chandigarh', 'Union Territory', 'Chandigarh', 'North', ['Chandigarh']],
        ['dadra-and-nagar-haveli-and-daman-and-diu', 'Dadra and Nagar Haveli and Daman and Diu', 'Union Territory', 'Daman', 'West', ['Daman', 'Silvassa', 'Diu']],
        ['delhi', 'Delhi', 'Union Territory', 'New Delhi', 'North', ['New Delhi', 'Dwarka', 'Rohini']],
        ['jammu-and-kashmir', 'Jammu and Kashmir', 'Union Territory', 'Srinagar', 'North', ['Srinagar', 'Jammu', 'Anantnag', 'Baramulla']],
        ['ladakh', 'Ladakh', 'Union Territory', 'Leh', 'North', ['Leh', 'Kargil']],
        ['lakshadweep', 'Lakshadweep', 'Union Territory', 'Kavaratti', 'South', ['Kavaratti']],
        ['puducherry', 'Puducherry', 'Union Territory', 'Puducherry', 'South', ['Puducherry', 'Karaikal', 'Yanam', 'Mahe']],
    ];
}

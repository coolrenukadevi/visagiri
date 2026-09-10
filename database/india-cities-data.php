<?php
declare(strict_types=1);

/**
 * Factual reference data only: city name, its state, and a short list of
 * well-known real localities within it (used to show genuine geographic
 * coverage, e.g. "we serve applicants across Bengaluru, including
 * Koramangala, Whitefield..."). This is NOT a claim of a branch office in
 * any of these areas — see the honest "how we serve you" copy in
 * location.php, which is identical to the state-page framing.
 *
 * Curated, not exhaustive: only cities with enough real, verifiable local
 * detail to justify a dedicated page. Delhi and Chandigarh are
 * deliberately excluded — both are single-city union territories already
 * fully covered by their /states/ page, so a separate city page would be
 * near-duplicate content.
 * Row shape: [slug, name, stateSlug, neighbourhoods[]]
 */
function all_india_cities_data(): array
{
    return [
        ['mumbai', 'Mumbai', 'maharashtra', ['Andheri', 'Bandra', 'Powai', 'Thane', 'Navi Mumbai']],
        ['bengaluru', 'Bengaluru', 'karnataka', ['Koramangala', 'Whitefield', 'Indiranagar', 'Electronic City', 'Jayanagar']],
        ['hyderabad', 'Hyderabad', 'telangana', ['Banjara Hills', 'Hitech City', 'Secunderabad', 'Gachibowli']],
        ['chennai', 'Chennai', 'tamil-nadu', ['T Nagar', 'Anna Nagar', 'Velachery', 'Adyar']],
        ['kolkata', 'Kolkata', 'west-bengal', ['Salt Lake', 'Park Street', 'Howrah', 'New Town']],
        ['pune', 'Pune', 'maharashtra', ['Koregaon Park', 'Hinjewadi', 'Kothrud', 'Viman Nagar']],
        ['ahmedabad', 'Ahmedabad', 'gujarat', ['Navrangpura', 'Satellite', 'Bopal', 'Maninagar']],
        ['jaipur', 'Jaipur', 'rajasthan', ['Malviya Nagar', 'Vaishali Nagar', 'C-Scheme']],
        ['lucknow', 'Lucknow', 'uttar-pradesh', ['Gomti Nagar', 'Hazratganj', 'Aliganj']],
        ['patna', 'Patna', 'bihar', ['Boring Road', 'Kankarbagh', 'Patliputra Colony']],
        ['gurugram', 'Gurugram', 'haryana', ['DLF Cyber City', 'Sohna Road', 'Golf Course Road']],
        ['noida', 'Noida', 'uttar-pradesh', ['Sector 18', 'Sector 62', 'Greater Noida']],
        ['ghaziabad', 'Ghaziabad', 'uttar-pradesh', ['Vaishali', 'Indirapuram', 'Raj Nagar']],
        ['faridabad', 'Faridabad', 'haryana', ['Sector 15', 'NIT Faridabad']],
        ['ranchi', 'Ranchi', 'jharkhand', ['Lalpur', 'Harmu', 'Kanke Road']],
        ['bhubaneswar', 'Bhubaneswar', 'odisha', ['Patia', 'Chandrasekharpur', 'Saheed Nagar']],
        ['kochi', 'Kochi', 'kerala', ['Kakkanad', 'Edappally', 'Marine Drive']],
        ['thiruvananthapuram', 'Thiruvananthapuram', 'kerala', ['Kowdiar', 'Pattom', 'Technopark']],
        ['indore', 'Indore', 'madhya-pradesh', ['Vijay Nagar', 'Palasia', 'Rajwada']],
        ['bhopal', 'Bhopal', 'madhya-pradesh', ['MP Nagar', 'Arera Colony', 'New Market']],
        ['nagpur', 'Nagpur', 'maharashtra', ['Dharampeth', 'Sadar', 'Civil Lines']],
        ['surat', 'Surat', 'gujarat', ['Adajan', 'Vesu', 'City Light']],
        ['vadodara', 'Vadodara', 'gujarat', ['Alkapuri', 'Fatehgunj', 'Gotri']],
        ['ludhiana', 'Ludhiana', 'punjab', ['Model Town', 'Sarabha Nagar']],
        ['amritsar', 'Amritsar', 'punjab', ['Ranjit Avenue', 'Lawrence Road']],
        ['dehradun', 'Dehradun', 'uttarakhand', ['Rajpur Road', 'Clement Town']],
        ['guwahati', 'Guwahati', 'assam', ['Ganeshguri', 'Zoo Road', 'Six Mile']],
        ['raipur', 'Raipur', 'chhattisgarh', ['Shankar Nagar', 'Civil Lines']],
        ['visakhapatnam', 'Visakhapatnam', 'andhra-pradesh', ['MVP Colony', 'Dwaraka Nagar', 'Rushikonda']],
        ['coimbatore', 'Coimbatore', 'tamil-nadu', ['RS Puram', 'Gandhipuram', 'Peelamedu']],
        ['madurai', 'Madurai', 'tamil-nadu', ['Anna Nagar', 'KK Nagar']],
        ['mysuru', 'Mysuru', 'karnataka', ['Vijayanagar', 'Saraswathipuram']],
        ['jamshedpur', 'Jamshedpur', 'jharkhand', ['Bistupur', 'Sakchi']],
    ];
}

<?php

namespace App\Services;

use App\Models\Customer;
use App\Models\Party;

/**
 * Find-or-create the customer, then resolve/create the canonical Party for
 * them — the shared first step of every module that intakes a new person
 * (Enquiry today, Attestation now too), so every module resolves to the
 * same Party instead of creating its own customer identity.
 */
class PartyResolver
{
    /**
     * @param  array{name:string,email?:string,mobile?:string,nationality?:string}  $customer
     * @return array{0: Customer, 1: Party}
     */
    public static function resolve(array $customer, string $source): array
    {
        $name = trim($customer['name'] ?? '');
        $email = trim($customer['email'] ?? '');
        $mobile = trim($customer['mobile'] ?? '');

        $customerModel = Customer::where(function ($q) use ($email, $mobile) {
            if ($email !== '') {
                $q->orWhere('email', $email);
            }
            if ($mobile !== '') {
                $q->orWhere('mobile', $mobile);
            }
        })->first();

        if (! $customerModel) {
            $customerModel = Customer::create([
                'name' => $name,
                'email' => $email ?: null,
                'mobile' => $mobile ?: null,
                'nationality' => $customer['nationality'] ?? null,
                'source' => $source,
            ]);
        }

        $party = Party::resolveFor($customerModel, 'customer');

        return [$customerModel, $party];
    }
}

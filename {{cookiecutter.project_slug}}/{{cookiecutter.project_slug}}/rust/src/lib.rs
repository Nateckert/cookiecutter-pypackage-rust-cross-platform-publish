use std::os::raw::{c_char, c_int};
use std::ffi::CStr;

#[no_mangle]
pub extern "C" fn hello(who: *const c_char) -> c_int {
    let who = unsafe { CStr::from_ptr(who) }.to_string_lossy();
    println!("Hello {} from Rust!", who);
    42
}

#[no_mangle]
pub extern "C" fn is_prime(n: *const c_int) -> c_int {
    let n = n as i32;
    if n < 2 {
        return 0
    }
    for i in 2 .. n {
        if  n % i == 0 {
            println!("{} % {} is 0", n, i);
            return 0
        }
    }
    1
} 

package com.commons.utils;

import java.util.UUID;

/**
 * @ClassName UUIDUtils
 * @Description TODO
 * @Author hyj98
 * @Date 2022-11-27 0:10
 * @Version 1.0
 */

public class UUIDUtils {
    public static String getUUID(){

        return UUID.randomUUID().toString().replaceAll("-", "");

    }
}

/*
 * MIT License
 *
 * Copyright (c) 2020 BioAgri S.r.l.s.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

package it.bioagri.utils;

import it.bioagri.api.ApiResponseStatus;
import it.bioagri.persistence.DataSource;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

public final class ApiUtils {

    private ApiUtils() { }


    private static <T> boolean doFilter(String name, String value, T instance, DataSource dataSource) {

        try {

            Method method;
            String methodName;

            if (name.indexOf('.') == -1)
                methodName = "get%s%s".formatted(Character.toUpperCase(name.charAt(0)), name.substring(1));
            else
                methodName = "get%s%s".formatted(Character.toUpperCase(name.charAt(0)), name.substring(1, name.indexOf('.')));


            try {

                method = instance
                        .getClass()
                        .getDeclaredMethod(methodName);

            } catch (NoSuchMethodException ignored) {

                method = instance
                        .getClass()
                        .getDeclaredMethod(methodName, DataSource.class);

            }

            method.setAccessible(true);

            if (method.getReturnType().equals(List.class)) {


                if (name.indexOf('.') == -1) {

                    return ((List<?>) method.invoke(instance, dataSource))
                            .stream()
                            .anyMatch(i -> i.toString().matches(value));

                } else {

                    return ((List<?>) method.invoke(instance, dataSource))
                            .stream()
                            .anyMatch(i -> {

                                try {

                                    Field field = i
                                            .getClass()
                                            .getDeclaredField(name.substring(name.indexOf('.') + 1));

                                    field.setAccessible(true);

                                    return field.get(i)
                                            .toString()
                                            .matches(value);

                                } catch (NoSuchFieldException | IllegalAccessException ignored) {
                                    throw new ApiResponseStatus(400);
                                }

                            });

                }

            } else {

                return method.invoke(instance)
                        .toString()
                        .matches(value);

            }

        } catch (IllegalAccessException | NoSuchMethodException | InvocationTargetException ignored) {
            throw new ApiResponseStatus(400);
        }

    }


    public static <T> boolean filterBy(List<String> names, List<String> values, T instance, DataSource dataSource) {

        if(names == null || names.isEmpty())
            return true;

        if(values == null || values.isEmpty())
            throw new ApiResponseStatus(400);

        if(names.size() != values.size())
            throw new ApiResponseStatus(400);


        final var i = names.iterator();
        final var j = values.iterator();

        while(i.hasNext() && j.hasNext()) {

            if (!doFilter(i.next(), j.next(), instance, dataSource))
                return false;

        }

        return true;

    }


    public static <T> int sortedBy(String name, String order, T a, T b) {

        if(name == null)
            return 0;

        if(order == null)
            throw new ApiResponseStatus(400);

        try {


            Method method = a
                    .getClass()
                    .getDeclaredMethod("get%s%s".formatted(Character.toUpperCase(name.charAt(0)), name.substring(1)));

            method.setAccessible(true);


            Object returnA;
            Object returnB;

            if(order.equalsIgnoreCase("asc")) {
                returnA = method.invoke(a);
                returnB = method.invoke(b);

            } else if(order.equalsIgnoreCase("desc")) {
                returnA = method.invoke(b);
                returnB = method.invoke(a);

            } else {
                throw new ApiResponseStatus(400);
            }



            if (method.getReturnType().equals(Double.class))
                return Double.compare((double) returnA, (double) returnB);

            if (method.getReturnType().equals(Long.class))
                return Long.compare((long) returnA, (long) returnB);

            if (method.getReturnType().equals(Integer.class))
                return Long.compare((int) returnA, (int) returnB);


            return returnA.toString().compareTo(returnB.toString());



        } catch (IllegalAccessException | NoSuchMethodException | InvocationTargetException ignored) {
            throw new ApiResponseStatus(400);
        }

    }

}

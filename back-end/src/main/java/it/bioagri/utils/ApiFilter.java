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

public final class ApiFilter {

    private ApiFilter() { }


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


    public static <T> boolean filterBy(String queryNames, String queryValues, T instance, DataSource dataSource) {

        if(queryNames == null)
            return true;

        if(queryValues == null)
            return false;


        final var names = queryNames.split("@");
        final var values = queryValues.split("@");

        if(names.length != values.length)
            throw new ApiResponseStatus(400);


        for(int i = 0; i < names.length; i++) {

            if (!doFilter(names[i], values[i], instance, dataSource))
                return false;

        }


        return true;

    }



}

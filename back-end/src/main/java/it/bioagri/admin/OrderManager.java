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

package it.bioagri.admin;


import it.bioagri.models.Order;
import it.bioagri.models.OrderStatus;
import it.bioagri.models.Product;
import it.bioagri.persistence.DataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class OrderManager {


    private final DataSource dataSource;


    public OrderManager(DataSource dataSource) {
        this.dataSource = dataSource;
    }


    @GetMapping("/admin/orders")
    public void getAllData(ModelMap model){

        List<CustomOrder> orders = new ArrayList<>();
        List<CustomOrder> pendingOrders = new ArrayList<>();
        String items;

        for(Order order : dataSource.getOrderDao().findAll()){

            items = "";

            for(Map.Entry<Product, Integer> product : order.getProducts(dataSource)){
                items += product.getKey().getName() + " ";
            }

            if(order.getStatus() == OrderStatus.PENDING)
                pendingOrders.add(new CustomOrder(order,items));
            else
                orders.add(new CustomOrder(order,items));

        }

        model.addAttribute("orders", orders);
        model.addAttribute("pendingOrders", pendingOrders);

    }


    @PostMapping("/admin/orders/update/status")
    public void updateStatus(@RequestParam long id, @RequestParam String shipmentNumber) {

        dataSource.update(
                """
                    UPDATE shop_order 
                    SET  status = 2, shipment_number = ?
                    WHERE id = ?
                    """,
                s -> {
                    s.setString(1,shipmentNumber);
                    s.setLong(2, id);
                });

    }


}
